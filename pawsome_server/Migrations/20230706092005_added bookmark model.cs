using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace pawsome_server.Migrations
{
    /// <inheritdoc />
    public partial class addedbookmarkmodel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "bookMarkModels",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PetId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PetId1 = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_bookMarkModels", x => x.Id);
                    table.ForeignKey(
                        name: "FK_bookMarkModels_Pets_PetId1",
                        column: x => x.PetId1,
                        principalTable: "Pets",
                        principalColumn: "PetId");
                });

            migrationBuilder.CreateIndex(
                name: "IX_bookMarkModels_PetId1",
                table: "bookMarkModels",
                column: "PetId1");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "bookMarkModels");
        }
    }
}
