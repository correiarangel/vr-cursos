package br.com.rangeldev.api_vr_curso.controller;

import br.com.rangeldev.api_vr_curso.controller.dto.CursoDTO;
import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;
import br.com.rangeldev.api_vr_curso.domain.entitties.Matricula;
import br.com.rangeldev.api_vr_curso.domain.repository.ICursoRepository;
import br.com.rangeldev.api_vr_curso.service.CursoService;
import br.com.rangeldev.api_vr_curso.service.ICursoService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class CursoControllerTest {

    @Mock
    private ICursoService cursoService;

    @Mock
    private ICursoRepository cursoRepository;

    @Mock
    private  Matricula matricula;

    @InjectMocks
    private CursoController cursoController;

    @BeforeEach
    void setUp() {
        cursoRepository = mock(ICursoRepository.class);
        cursoService = mock(CursoService.class);
        MockitoAnnotations.openMocks(this);
        MockHttpServletRequest request = new MockHttpServletRequest();
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
    }

    Curso createCurso(Long cont) {
        List<Long> matriculas = new ArrayList<>();
        matriculas.add(matricula.getCodigo());
        Curso curso = new Curso();
        curso.setCodigo(cont);
        curso.setDescricao("Descrição " + cont);
        curso.setEmenta("Ementa " + cont);
        curso.setCursoCodigosMatriculas(matriculas);

        return curso;
    }

    CursoDTO createDto(Curso curso) {
        return new CursoDTO(curso.getCodigo(), curso.getDescricao(), curso.getEmenta(), curso.getCursoCodigosMatriculas());
    }

    @Test
    void testFindAll() {

        Curso curso1 = createCurso(1L);
        Curso curso2 = createCurso(2L);
        ;

        List<Curso> cursos = Arrays.asList(curso1, curso2);

        when(cursoService.findAll()).thenReturn(cursos);

        ResponseEntity<List<CursoDTO>> response = cursoController.findAll();
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(2, response.getBody().size());
        verify(cursoService, times(1)).findAll();
    }

    @Test
    void testFindById() {
        Curso curso = createCurso(1L);

        when(cursoService.findById(1L)).thenReturn(curso);

        ResponseEntity<CursoDTO> response = cursoController.findById(1L);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("Descrição 1", response.getBody().descricao());
        verify(cursoService, times(1)).findById(1L);
    }

    @Test
    void testCreate() {

        Curso curso = createCurso(11L);
        CursoDTO cursoDTO = createDto(curso);
       
        when(cursoService.create(any(Curso.class))).thenReturn(curso);


        ResponseEntity<CursoDTO> resultado = cursoController.create(cursoDTO);


        assertEquals(resultado.getBody().descricao(), "Descrição 11");
    }

    @Test
    void testDelete() {
        doNothing().when(cursoService).delete(1L);

        ResponseEntity<Void> response = cursoController.delete(1L);
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        verify(cursoService, times(1)).delete(1L);
    }
}