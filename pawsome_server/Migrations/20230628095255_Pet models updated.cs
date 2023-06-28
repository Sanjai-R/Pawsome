using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class Petmodelsupdated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel");

            migrationBuilder.DropColumn(
                name: "Owner",
                table: "PetsModel");

            migrationBuilder.DropColumn(
                name: "Species",
                table: "PetsModel");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "PetsModel",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "OwnerId",
                table: "PetsModel",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel");

            migrationBuilder.DropColumn(
                name: "OwnerId",
                table: "PetsModel");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "PetsModel",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Owner",
                table: "PetsModel",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Species",
                table: "PetsModel",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_PetsModel_Users_UserId",
                table: "PetsModel",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
