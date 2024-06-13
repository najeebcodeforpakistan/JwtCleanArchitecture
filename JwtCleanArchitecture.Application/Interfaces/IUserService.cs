using JwtCleanArchitecture.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JwtCleanArchitecture.Application.Interfaces
{
    public interface IUserService
    {
        Task<int> Signup(User user);
        Task<(User user, string token)> Authenticate(string username, string password, string ipAddress, string device, string browser);
        Task<double> GetBalance(int userId);
    }
}
