using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class EventMealWalkTrackerAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PetsModel_PetCategoryModel_CategoryId",
                table: "PetsModel");

            migrationBuilder.DropForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PetsModel",
                table: "PetsModel");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PetCategoryModel",
                table: "PetCategoryModel");

            migrationBuilder.RenameTable(
                name: "PetsModel",
                newName: "Pets");

            migrationBuilder.RenameTable(
                name: "PetCategoryModel",
                newName: "PetCategory");

            migrationBuilder.RenameIndex(
                name: "IX_PetsModel_UserId",
                table: "Pets",
                newName: "IX_Pets_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_PetsModel_CategoryId",
                table: "Pets",
                newName: "IX_Pets_CategoryId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Pets",
                table: "Pets",
                column: "PetId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PetCategory",
                table: "PetCategory",
                column: "CategoryId");

            migrationBuilder.CreateTable(
                name: "Events",
                columns: table => new
                {
                    EventId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PetId = table.Column<int>(type: "int", nullable: false),
                    EventDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EventTitle = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    EventDesc = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    HasReminder = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Events", x => x.EventId);
                    table.ForeignKey(
                        name: "FK_Events_Pets_PetId",
                        column: x => x.PetId,
                        principalTable: "Pets",
                        principalColumn: "PetId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NutrientTracker",
                columns: table => new
                {
                    NutrientTrackerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProteinPlan = table.Column<int>(type: "int", nullable: false),
                    ProteinConsumed = table.Column<int>(type: "int", nullable: false),
                    FatPlan = table.Column<int>(type: "int", nullable: false),
                    FatConsumed = table.Column<int>(type: "int", nullable: false),
                    CarbsPlan = table.Column<int>(type: "int", nullable: false),
                    CarbsConsumed = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NutrientTracker", x => x.NutrientTrackerId);
                });

            migrationBuilder.CreateTable(
                name: "WalkingTracker",
                columns: table => new
                {
                    WalkingTrackerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    WalkingGoalMinutes = table.Column<int>(type: "int", nullable: false),
                    MinutesCovered = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WalkingTracker", x => x.WalkingTrackerId);
                });

            migrationBuilder.CreateTable(
                name: "MealTracker",
                columns: table => new
                {
                    MealTrackerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DailyPlan = table.Column<int>(type: "int", nullable: false),
                    FoodConsumed = table.Column<int>(type: "int", nullable: false),
                    NutrientTrackerId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MealTracker", x => x.MealTrackerId);
                    table.ForeignKey(
                        name: "FK_MealTracker_NutrientTracker_NutrientTrackerId",
                        column: x => x.NutrientTrackerId,
                        principalTable: "NutrientTracker",
                        principalColumn: "NutrientTrackerId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Events_PetId",
                table: "Events",
                column: "PetId");

            migrationBuilder.CreateIndex(
                name: "IX_MealTracker_NutrientTrackerId",
                table: "MealTracker",
                column: "NutrientTrackerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Pets_PetCategory_CategoryId",
                table: "Pets",
                column: "CategoryId",
                principalTable: "PetCategory",
                principalColumn: "CategoryId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Pets_Users_UserId",
                table: "Pets",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Pets_PetCategory_CategoryId",
                table: "Pets");

            migrationBuilder.DropForeignKey(
                name: "FK_Pets_Users_UserId",
                table: "Pets");

            migrationBuilder.DropTable(
                name: "Events");

            migrationBuilder.DropTable(
                name: "MealTracker");

            migrationBuilder.DropTable(
                name: "WalkingTracker");

            migrationBuilder.DropTable(
                name: "NutrientTracker");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Pets",
                table: "Pets");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PetCategory",
                table: "PetCategory");

            migrationBuilder.RenameTable(
                name: "Pets",
                newName: "PetsModel");

            migrationBuilder.RenameTable(
                name: "PetCategory",
                newName: "PetCategoryModel");

            migrationBuilder.RenameIndex(
                name: "IX_Pets_UserId",
                table: "PetsModel",
                newName: "IX_PetsModel_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_Pets_CategoryId",
                table: "PetsModel",
                newName: "IX_PetsModel_CategoryId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PetsModel",
                table: "PetsModel",
                column: "PetId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PetCategoryModel",
                table: "PetCategoryModel",
                column: "CategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_PetsModel_PetCategoryModel_CategoryId",
                table: "PetsModel",
                column: "CategoryId",
                principalTable: "PetCategoryModel",
                principalColumn: "CategoryId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");
        }
    }
}
