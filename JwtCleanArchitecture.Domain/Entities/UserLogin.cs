using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JwtCleanArchitecture.Domain.Entities
{
    public class UserLogin
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string IPAddress { get; set; }
        public string Device { get; set; }
        public string Browser { get; set; }
        public DateTime LoginTime { get; set; }
    }
}
