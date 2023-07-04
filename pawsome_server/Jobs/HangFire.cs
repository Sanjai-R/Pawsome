using pawsome_server.Data;
using Microsoft.EntityFrameworkCore;
namespace pawsome_server.Jobs
{
    public class HangfireTestJobService : IHangfireTestJobService
    {
        private readonly ApplicationDbContext _dbContext;

        public HangfireTestJobService(ApplicationDbContext dbContext) {
            _dbContext = dbContext;
        }


    }
}
