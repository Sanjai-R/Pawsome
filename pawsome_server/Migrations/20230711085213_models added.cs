using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class modelsadded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_bookMarkModels_Pets_PetId",
                table: "bookMarkModels");

            migrationBuilder.DropPrimaryKey(
                name: "PK_foodProducts",
                table: "foodProducts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_bookMarkModels",
                table: "bookMarkModels");

            migrationBuilder.RenameTable(
                name: "foodProducts",
                newName: "FoodProducts");

            migrationBuilder.RenameTable(
                name: "bookMarkModels",
                newName: "BookMarkModels");

            migrationBuilder.RenameColumn(
                name: "NotificationId",
                table: "Users",
                newName: "Profile");

            migrationBuilder.RenameIndex(
                name: "IX_bookMarkModels_PetId",
                table: "BookMarkModels",
                newName: "IX_BookMarkModels_PetId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_FoodProducts",
                table: "FoodProducts",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_BookMarkModels",
                table: "BookMarkModels",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "Notifications",
                columns: table => new
                {
                    NotificationId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NotificationTitle = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    NotificationBody = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notifications", x => x.NotificationId);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_BookMarkModels_Pets_PetId",
                table: "BookMarkModels",
                column: "PetId",
                principalTable: "Pets",
                principalColumn: "PetId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_BookMarkModels_Pets_PetId",
                table: "BookMarkModels");

            migrationBuilder.DropTable(
                name: "Notifications");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FoodProducts",
                table: "FoodProducts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_BookMarkModels",
                table: "BookMarkModels");

            migrationBuilder.RenameTable(
                name: "FoodProducts",
                newName: "foodProducts");

            migrationBuilder.RenameTable(
                name: "BookMarkModels",
                newName: "bookMarkModels");

            migrationBuilder.RenameColumn(
                name: "Profile",
                table: "Users",
                newName: "NotificationId");

            migrationBuilder.RenameIndex(
                name: "IX_BookMarkModels_PetId",
                table: "bookMarkModels",
                newName: "IX_bookMarkModels_PetId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_foodProducts",
                table: "foodProducts",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_bookMarkModels",
                table: "bookMarkModels",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_bookMarkModels_Pets_PetId",
                table: "bookMarkModels",
                column: "PetId",
                principalTable: "Pets",
                principalColumn: "PetId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
