using AutoMapper;
using pawsome_server.Dto;
using pawsome_server.Models;

namespace pawsome_server.Profiles
    {
    public class PetProfile:Profile
        {
        public PetProfile()
        {
            CreateMap<PetDto, Pet>();
        }
    }
    }
