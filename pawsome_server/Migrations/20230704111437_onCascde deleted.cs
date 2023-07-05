using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class onCascdedeleted : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Pets_PetId",
                table: "Adoption");

            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Users_UserId",
                table: "Adoption");

            migrationBuilder.DropIndex(
                name: "IX_Adoption_UserId",
                table: "Adoption");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Adoption");

            migrationBuilder.RenameColumn(
                name: "date",
                table: "Adoption",
                newName: "Date");

            migrationBuilder.CreateIndex(
                name: "IX_Adoption_BuyerId",
                table: "Adoption",
                column: "BuyerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Pets_PetId",
                table: "Adoption",
                column: "PetId",
                principalTable: "Pets",
                principalColumn: "PetId",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption",
                column: "BuyerId",
                principalTable: "Users",
                principalColumn: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Pets_PetId",
                table: "Adoption");

            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption");

            migrationBuilder.DropIndex(
                name: "IX_Adoption_BuyerId",
                table: "Adoption");

            migrationBuilder.RenameColumn(
                name: "Date",
                table: "Adoption",
                newName: "date");

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "Adoption",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Adoption_UserId",
                table: "Adoption",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Pets_PetId",
                table: "Adoption",
                column: "PetId",
                principalTable: "Pets",
                principalColumn: "PetId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Users_UserId",
                table: "Adoption",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");
        }
    }
}
