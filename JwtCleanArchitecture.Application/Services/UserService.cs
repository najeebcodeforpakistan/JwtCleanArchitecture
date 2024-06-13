using JwtCleanArchitecture.Application.Interfaces;
using JwtCleanArchitecture.Domain.Entities;
using JwtCleanArchitecture.Infrastructure.Repository;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace JwtCleanArchitecture.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IConfiguration _configuration;

        public UserService(IUserRepository userRepository, IConfiguration configuration)
        {
            _userRepository = userRepository;
            _configuration = configuration;
        }

        public async Task<int> Signup(User user)
        {
            user.CreatedAt = DateTime.UtcNow;
            user.Balance = 0;  // Initial balance
            return await _userRepository.AddUser(user);
        }

        public async Task<(User user, string token)> Authenticate(string username, string password, string ipAddress, string device, string browser)
        {
            var user = await _userRepository.GetUserByUsername(username);
            if (user == null || user.Password != password)
            {
                throw new UnauthorizedAccessException("Invalid credentials");
            }

            var isFirstLogin = await _userRepository.IsFirstLogin(user.Id);
            var userLogin = new UserLogin
            {
                UserId = user.Id,
                IPAddress = ipAddress,
                Device = device,
                Browser = browser,
                LoginTime = DateTime.UtcNow
            };

            await _userRepository.AddUserLogin(userLogin);

            if (isFirstLogin)
            {
                user.Balance += 5;
                await _userRepository.UpdateUser(user);
            }

            var token = GenerateJwtToken(user);

            return (user, token);
        }

        public async Task<double> GetBalance(int userId)
        {
            var user = await _userRepository.GetUserById(userId);
            return user.Balance;
        }

        private string GenerateJwtToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Username),
                    new Claim("id", user.Id.ToString())  // Ensure this claim is added
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                Issuer = _configuration["Jwt:Issuer"],
                Audience = _configuration["Jwt:Audience"],
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

    }
}
