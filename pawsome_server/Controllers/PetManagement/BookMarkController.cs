using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Dto.Request.PetManagement;
using pawsome_server.Models.PetManagement;

namespace pawsome_server.Controllers.PetManagement
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookMarkController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public BookMarkController(ApplicationDbContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }
        // GET: api/BookMark
        [HttpGet]
        public async Task<ActionResult<IEnumerable<BookMarkModel>>> GetbookMarkModels()
        {
            return await _context.bookMarkModels.ToListAsync();
        }

        // GET: api/BookMark/5
        [HttpGet("{id}")]
        public async Task<ActionResult<BookMarkModel>> GetBookMarkModel(int id)
        {
            var bookMarks = await _context.bookMarkModels.Include(c => c.Pet).Where(c => c.UserId == id).ToListAsync();
            if (bookMarks == null)
            {
                return NotFound();
            }

            return Ok(bookMarks);
        }

        // PUT: api/BookMark/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBookMarkModel(int id, BookMarkModel bookMarkModel)
        {
            if (id != bookMarkModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(bookMarkModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BookMarkModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/BookMark
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<BookMarkModel>> PostBookMarkModel(AddBookmarkDto dto)
        {
            BookMarkModel bookMarkModel = _mapper.Map<BookMarkModel>(dto);

            try
            {
                _context.bookMarkModels.Add(bookMarkModel);
                await _context.SaveChangesAsync();

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return BadRequest(ex.Message);
            }

            return Ok(bookMarkModel);
        }

        // DELETE: api/BookMark/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBookMarkModel(int id)
        {
            var bookMarkModel = await _context.bookMarkModels.FindAsync(id);
            if (bookMarkModel == null)
            {
                return NotFound();
            }

            _context.bookMarkModels.Remove(bookMarkModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool BookMarkModelExists(int id)
        {
            return _context.bookMarkModels.Any(e => e.Id == id);
        }
    }
}
