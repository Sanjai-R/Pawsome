using Hangfire;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using StackExchange.Redis;
using Microsoft.AspNetCore.Hosting;

using Microsoft.Extensions.Configuration;
using Hangfire.SqlServer;
using pawsome_server.Controllers.PetTracker;

namespace pawsome_server
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            // Add services to the container.
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddHangfire(configuration => configuration
              .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
              .UseSimpleAssemblyNameTypeSerializer()
              .UseRecommendedSerializerSettings()
              .UseSqlServerStorage(builder.Configuration.GetConnectionString("Db"), new SqlServerStorageOptions
              {
                  CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
                  SlidingInvisibilityTimeout = TimeSpan.FromMinutes(5),
                  QueuePollInterval = TimeSpan.Zero,
                  UseRecommendedIsolationLevel = true,
                  DisableGlobalLocks = true
              }));
            builder.Services.AddHangfireServer();

            builder.Services.AddSingleton<IConnectionMultiplexer>(ConnectionMultiplexer.Connect("localhost:6379")); //redis

            builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
              options.UseSqlServer(builder.Configuration.GetConnectionString("Db")));

            var app = builder.Build();
            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            //        app.UseHttpsRedirection();
            using (var scope = app.Services.CreateScope())
            {
                var serviceProvider = scope.ServiceProvider;
                var recurringJobManager = serviceProvider.GetRequiredService<IRecurringJobManager>();

                // Schedule the ResetAllNutrientTrackerModel method to run daily at 5 AM
                RecurringJob.AddOrUpdate<NutrientTrackerController>("ResetAllNutrientTrackerModel", x => x.ResetAllNutrientTrackerModel(), Cron.Daily(5, 0));


            }
            app.UseAuthorization();
            app.UseCors(options => options.WithOrigins("*").AllowAnyMethod().AllowAnyHeader());
            app.UseHangfireDashboard("/dashboard");
            app.MapControllers();

            app.Run();

        }


    }
}