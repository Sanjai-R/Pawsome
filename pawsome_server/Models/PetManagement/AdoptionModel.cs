using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using pawsome_server.Models.Shared;

namespace pawsome_server.Models.PetManagement
{
    public class AdoptionModel
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("Pets")]
        public int PetId { get; set; }

        [ForeignKey("Users")]
        public int BuyerId { get; set; }

        [Required]
        public string Status { get; set; }

        [Required]
        public DateTime Date { get; set; }

        public virtual Pet Pet { get; set; }
        public virtual UserModel User { get; set; }

    }
}
