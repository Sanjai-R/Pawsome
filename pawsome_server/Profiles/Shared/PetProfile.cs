using AutoMapper;
using pawsome_server.Dto.Request.Shared;
using pawsome_server.Models.Shared;

namespace pawsome_server.Profiles
{
    public class PetProfile : Profile
    {
        public PetProfile() {
            CreateMap<PostPetDto, Pet>();
        }
    }
}
