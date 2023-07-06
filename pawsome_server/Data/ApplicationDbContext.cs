using Microsoft.EntityFrameworkCore;
using pawsome_server.Models;
using pawsome_server.Models.PetManagement;
using pawsome_server.Models.PetTracker;
using pawsome_server.Models.Shared;

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

        public DbSet<AdoptionModel> Adoption { get; set; }
        
        public DbSet<WalkingTrackerModel> WalkingTracker { get; set; }

        public DbSet<BookMarkModel> bookMarkModels { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            base.OnModelCreating(modelBuilder);

            // Configure the relationships
            modelBuilder.Entity<AdoptionModel>()
                .HasOne(adoption => adoption.Pet)
                .WithMany()
                .HasForeignKey(adoption => adoption.PetId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<AdoptionModel>()
                .HasOne(adoption => adoption.Buyer)
                .WithMany()
                .HasForeignKey(adoption => adoption.BuyerId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
