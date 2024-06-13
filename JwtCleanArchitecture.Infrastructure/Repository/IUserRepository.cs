using JwtCleanArchitecture.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JwtCleanArchitecture.Infrastructure.Repository
{
    public interface IUserRepository
    {
        Task<int> AddUser(User user);
        Task<User> GetUserByUsername(string username);
        Task<User> GetUserById(int id);
        Task<int> AddUserLogin(UserLogin userLogin);
        Task UpdateUser(User user);  // Add this line
        Task<bool> IsFirstLogin(int userId);
    }
}
