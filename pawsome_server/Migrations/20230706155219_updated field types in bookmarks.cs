using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class updatedfieldtypesinbookmarks : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_bookMarkModels_Pets_PetId1",
                table: "bookMarkModels");

            migrationBuilder.DropIndex(
                name: "IX_bookMarkModels_PetId1",
                table: "bookMarkModels");

            migrationBuilder.DropColumn(
                name: "PetId1",
                table: "bookMarkModels");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "bookMarkModels",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<int>(
                name: "PetId",
                table: "bookMarkModels",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.CreateIndex(
                name: "IX_bookMarkModels_PetId",
                table: "bookMarkModels",
                column: "PetId");

            migrationBuilder.AddForeignKey(
                name: "FK_bookMarkModels_Pets_PetId",
                table: "bookMarkModels",
                column: "PetId",
                principalTable: "Pets",
                principalColumn: "PetId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_bookMarkModels_Pets_PetId",
                table: "bookMarkModels");

            migrationBuilder.DropIndex(
                name: "IX_bookMarkModels_PetId",
                table: "bookMarkModels");

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                table: "bookMarkModels",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<string>(
                name: "PetId",
                table: "bookMarkModels",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "PetId1",
                table: "bookMarkModels",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_bookMarkModels_PetId1",
                table: "bookMarkModels",
                column: "PetId1");

            migrationBuilder.AddForeignKey(
                name: "FK_bookMarkModels_Pets_PetId1",
                table: "bookMarkModels",
                column: "PetId1",
                principalTable: "Pets",
                principalColumn: "PetId");
        }
    }
}
