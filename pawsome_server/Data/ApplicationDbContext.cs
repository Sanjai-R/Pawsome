using Microsoft.EntityFrameworkCore;
using pawsome_server.Models;

namespace pawsome_server.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<UserModel> Users { get; set; }
        public DbSet<Pet> Pets { get; set; }
        public DbSet<PetCategory> PetCategory { get; set; }
        public DbSet<EventModal> Events { get; set; }
        public DbSet<MealTrackerModel> MealTracker { get; set; }
        public DbSet<NutrientTrackerModel> NutrientTracker { get; set; }
        public DbSet<WalkingTrackerModel> WalkingTracker { get; set; }

    }
}
