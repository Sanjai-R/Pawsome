using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class AddedpetIdfieldinMealTracker : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PetId",
                table: "WalkingTracker",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "PetId",
                table: "MealTracker",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PetId",
                table: "WalkingTracker");

            migrationBuilder.DropColumn(
                name: "PetId",
                table: "MealTracker");
        }
    }
}
