using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class onCascdedelete : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption");

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption",
                column: "BuyerId",
                principalTable: "Users",
                principalColumn: "UserId",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption");

            migrationBuilder.AddForeignKey(
                name: "FK_Adoption_Users_BuyerId",
                table: "Adoption",
                column: "BuyerId",
                principalTable: "Users",
                principalColumn: "UserId");
        }
    }
}
