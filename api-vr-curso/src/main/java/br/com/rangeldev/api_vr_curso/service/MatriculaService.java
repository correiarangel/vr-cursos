package br.com.rangeldev.api_vr_curso.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;
import br.com.rangeldev.api_vr_curso.domain.entitties.Matricula;
import br.com.rangeldev.api_vr_curso.domain.repository.IAlunoRepository;
import br.com.rangeldev.api_vr_curso.domain.repository.ICursoRepository;
import br.com.rangeldev.api_vr_curso.domain.repository.IMatriculaRepository;
import br.com.rangeldev.api_vr_curso.service.exeception.BusinessException;
import br.com.rangeldev.api_vr_curso.service.exeception.NotFoundException;

@Service
public class MatriculaService implements IMatriculaSevice {

    @Autowired
    private IMatriculaRepository matriculaRepository;

    @Autowired
    private IAlunoRepository alunoRepository;

    @Autowired
    private ICursoRepository cursoRepository;

    @Override
    public List<Matricula> findAll() {
        return matriculaRepository.findAll();
    }

    @Override
    public Matricula findById(Long id) {
        return this.matriculaRepository.findById(id).orElseThrow(NotFoundException::new);
    }

    @Override
    public Matricula create(Matricula entity) {
        Aluno aluno = alunoRepository.findById(entity.getAluno().getCodigo())
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Not found student ID: " + entity.getAluno().getCodigo()));

        Curso curso = cursoRepository.findById(entity.getCurso().getCodigo())
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Not found curser ID: " + entity.getCurso().getCodigo()));

        Matricula matricula = new Matricula();
        matricula.setAluno(aluno);
        matricula.setCurso(curso);

        return matriculaRepository.save(matricula);
    }

    @Override
    public Matricula update(Long id, Matricula entity) {
        Matricula matricula = this.findById(id);

        if (!matricula.getCodigo().equals(id)) {
            throw new BusinessException("OPS! This register not exists.");
        }
        matricula.setAluno(entity.getAluno());
        matricula.setCurso(entity.getCurso());
        return this.matriculaRepository.save(matricula);
    }

    @Override
    public void delete(Long id) {

        if (!matriculaRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Register not exists ID: " + id);
        }

        matriculaRepository.deleteById(id);
    }
}