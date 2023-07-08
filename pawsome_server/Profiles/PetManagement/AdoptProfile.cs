using AutoMapper;
using pawsome_server.Dto.Request.PetTracker;
using pawsome_server.Models.PetManagement;


namespace pawsome_server.Profiles.PetTracker
{
    public class AdoptProfile : Profile
    {
        public AdoptProfile()
        {
            CreateMap<AdoptDto, AdoptionModel>();
        }
    }
}
