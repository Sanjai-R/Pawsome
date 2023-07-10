using Hangfire;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using StackExchange.Redis;
using Microsoft.AspNetCore.Hosting;

using Microsoft.Extensions.Configuration;
using Hangfire.SqlServer;
using pawsome_server.Controllers.PetTracker;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using Azure.Core;

namespace pawsome_server
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);


            SecretClientOptions options = new SecretClientOptions()
            {
                Retry = {
          Delay = TimeSpan.FromSeconds(2),
          MaxDelay = TimeSpan.FromSeconds(16),
          MaxRetries = 5,
          Mode = RetryMode.Exponential
        }
            };
            var client = new SecretClient(new Uri("https://pawsome-api.vault.azure.net/"), new DefaultAzureCredential(), options);

            KeyVaultSecret db = client.GetSecret("db");
            KeyVaultSecret cacheDb = client.GetSecret("cache-db");
            string secretValue = db.Value;
            string cacheSecretValue = cacheDb.Value;
            // Add services to the container.
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddHangfire(configuration => configuration
              .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
              .UseSimpleAssemblyNameTypeSerializer()
              .UseRecommendedSerializerSettings()
              .UseSqlServerStorage(secretValue, new SqlServerStorageOptions
              {
                  CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
                  SlidingInvisibilityTimeout = TimeSpan.FromMinutes(5),
                  QueuePollInterval = TimeSpan.Zero,
                  UseRecommendedIsolationLevel = true,
                  DisableGlobalLocks = true
              }));
            builder.Services.AddHangfireServer();

            Console.WriteLine(secretValue);

            builder.Services.AddSingleton<IConnectionMultiplexer>(ConnectionMultiplexer.Connect(cacheSecretValue)); //redis

            builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
              options.UseSqlServer(secretValue));

            var app = builder.Build();
            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

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
            app.UseHttpsRedirection();
            app.Run();

        }

    }
}