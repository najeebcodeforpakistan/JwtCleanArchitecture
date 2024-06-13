using JwtCleanArchitecture.Application.Interfaces;
using JwtCleanArchitecture.Common.DTOs;
using JwtCleanArchitecture.Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JwtCleanArchitecture.API.Controllers
{
    [ApiController]
    [Route("[controller]")]

    public class UsersController : Controller
    {
        
            private readonly IUserService _userService;

            public UsersController(IUserService userService)
            {
                _userService = userService;
            }

        [HttpPost("signup")]
        public async Task<IActionResult> Signup([FromBody] User user)
        {
            var userId = await _userService.Signup(user);
            return Ok(new { UserId = userId });
        }

        [HttpPost("authenticate")]
        public async Task<IActionResult> Authenticate([FromBody] AuthenticateRequest request)
        {
            var (user, token) = await _userService.Authenticate(request.Username, request.Password, request.IpAddress, request.Device, request.Browser);
            return Ok(new { user.FirstName, user.LastName, Token = token });
        }

        [HttpPost("auth/balance")]
        [Authorize]
        public async Task<IActionResult> GetBalance()
        {
            var userId = int.Parse(User.Claims.First(c => c.Type == "id").Value);
            var balance = await _userService.GetBalance(userId);
            return Ok(new { Balance = balance });
        }

    }
}

