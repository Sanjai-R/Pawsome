using pawsome_server.Models.Shared;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Models.PetManagement
{
    public class BookMarkModel
    {
        
        [Key]
        public int Id { get; set; }

        [ForeignKey("Pets")]
        [Required]
        public int PetId { get; set; }

        [Required]
        public int UserId{ get; set;}

        public virtual Pet Pet { get; set; }
    }
}
