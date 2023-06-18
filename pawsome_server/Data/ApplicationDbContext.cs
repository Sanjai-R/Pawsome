using Microsoft.EntityFrameworkCore;
using pawsome_server.Models;

namespace pawsome_server.Data
    {
    public class ApplicationDbContext:DbContext
        {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<UserModel> Users { get; set; }
        }
    }
