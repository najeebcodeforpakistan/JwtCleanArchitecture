using Dapper;
using JwtCleanArchitecture.Domain.Entities;
using JwtCleanArchitecture.Infrastructure.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JwtCleanArchitecture.Infrastructure.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly DapperContext _context;

        public UserRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<int> AddUser(User user)
        {
            var sql =
                "INSERT INTO Users (Username, Password, FirstName, LastName, Device, IPAddress, CreatedAt, Balance) VALUES (@Username, @Password, @FirstName, @LastName, @Device, @IPAddress, @CreatedAt, @Balance); SELECT CAST(SCOPE_IDENTITY() as int)";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleAsync<int>(sql, user);
            }
        }

        public async Task<User> GetUserByUsername(string username)
        {
            var sql = "SELECT * FROM Users WHERE Username = @Username";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleOrDefaultAsync<User>(sql, new { Username = username });
            }
        }

        public async Task<User> GetUserById(int id)
        {
            var sql = "SELECT * FROM Users WHERE Id = @Id";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleOrDefaultAsync<User>(sql, new { Id = id });
            }
        }

        public async Task<int> AddUserLogin(UserLogin userLogin)
        {
            var sql =
                "INSERT INTO UserLogins (UserId, IPAddress, Device, Browser, LoginTime) VALUES (@UserId, @IPAddress, @Device, @Browser, @LoginTime); SELECT CAST(SCOPE_IDENTITY() as int)";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleAsync<int>(sql, userLogin);
            }
        }

        public async Task UpdateUser(User user) // Add this method
        {
            var sql =
                "UPDATE Users SET Username = @Username, Password = @Password, FirstName = @FirstName, LastName = @LastName, Device = @Device, IPAddress = @IPAddress, CreatedAt = @CreatedAt, Balance = @Balance WHERE Id = @Id";
            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(sql, user);
            }
        }
        public async Task<bool> IsFirstLogin(int userId)
        {
            using var connection = _context.CreateConnection();
            var sql = "SELECT COUNT(*) FROM UserLogins WHERE UserId = @UserId";
            var count = await connection.ExecuteScalarAsync<int>(sql, new { UserId = userId });
            return count == 0; // If count is 0, it's the first login
        }
    }
}
