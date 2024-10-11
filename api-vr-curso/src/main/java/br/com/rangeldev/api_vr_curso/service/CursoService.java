package br.com.rangeldev.api_vr_curso.service;


import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;

import br.com.rangeldev.api_vr_curso.domain.repository.ICursoRepository;
import br.com.rangeldev.api_vr_curso.service.exeception.BusinessException;
import br.com.rangeldev.api_vr_curso.service.exeception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static java.util.Optional.ofNullable;

@Service
public class CursoService implements ICursoService {

    @Autowired
    private ICursoRepository repository;


    @Transactional(readOnly = true)
    @Override
    public List<Curso> findAll() {
        return repository.findAll();
    }

    @Override
    public Curso findById(Long id) {
        return this.repository.findById(id).orElseThrow( NotFoundException::new);
    }



    @Override
    public Curso create(Curso entity) {
        ofNullable(entity).orElseThrow(() -> new BusinessException("Ops! This curse not null."));

        if (entity.getDescricao().isEmpty()) {
            throw new BusinessException("Ops! This student number already exists.");
        }
        return this.repository.save(entity);
    }

    @Transactional
    @Override
    public void delete(Long id) {
       Curso dbCurso = this.findById(id);
       boolean  isAluno =  dbCurso.getCursoCodigosMatriculas().isEmpty();
       if(!isAluno){
           throw new BusinessException("Ops! course cannot be deleted with student enrolled.");
       }
       repository.deleteById(dbCurso.getCodigo());
    }


    @Transactional
    @Override
    public Curso update(Long id, Curso entity)  {

        Curso dbCurso = this.findById(id);

        if (!dbCurso.getCodigo().equals(id)) {
            throw new BusinessException("OPS! This curse not exists.");
        }
        dbCurso.setDescricao(entity.getDescricao());
        dbCurso.setCursoCodigosMatriculas(entity.getCursoCodigosMatriculas());
        return this.repository.save(dbCurso);
    }


}
