package br.com.rangeldev.api_vr_curso.service;

import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import br.com.rangeldev.api_vr_curso.domain.repository.IAlunoRepository;
import br.com.rangeldev.api_vr_curso.service.exeception.BusinessException;
import br.com.rangeldev.api_vr_curso.service.exeception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static java.util.Optional.ofNullable;

@Service
public class AlunoService  implements IAlunoService {
    private static final Long UNCHANGEABLE_ALUNO_ID = 1L;
    @Autowired
    private   IAlunoRepository repository;


    @Transactional(readOnly = true)
    @Override
    public List<Aluno> findAll() {
        return repository.findAll();
    }

    @Override
    public Aluno findById(Long id) {
        System.out.println("//////// DEVE BUSCAR > " + id);
        return this.repository.findById(id).orElseThrow( NotFoundException::new);
    }

    @Override
    public Aluno create(Aluno entity) {
        ofNullable(entity).orElseThrow(() -> new BusinessException("Ops! This student not null."));

       // this.validateChangeableId(entity.getCodigo(), "created");
        if (entity.getNome().isEmpty()) {
            throw new BusinessException("Ops! This student number already exists.");
        }

        return this.repository.save(entity);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        //this.validateChangeableId(id, "deleted");
        Aluno dbAluno = this.findById(id);

        boolean  isAluno =  dbAluno.getAlunoCodigosMatriculas().isEmpty();
        if(!isAluno){
            throw new BusinessException("Ops! student cannot be deleted with course enrolled.");
        }
        if(dbAluno.getNome()==null||dbAluno.getNome().isEmpty()){
            throw new BusinessException("Ops! student cannot be deleted not exist.");
        }
        System.out.println("//////// DEVE DELETAR > " + id);
        repository.deleteById(dbAluno.getCodigo());
    }


    @Transactional
    @Override
    public Aluno update(Long id, Aluno entity) {
      //  this.validateChangeableId(id, "updated");
        Aluno dbAluno = this.findById(id);

        if (dbAluno.getCodigo()==null || !dbAluno.getCodigo().equals(id)) {
            System.out.println("//////// ALUNO NÃO EXIST " + id);
            throw new BusinessException("OPS! This student not exists.");
        }
        dbAluno.setNome(entity.getNome());
        dbAluno.setAlunoCodigosMatriculas(entity.getAlunoCodigosMatriculas());
        return this.repository.save(dbAluno);
    }

   /* private void validateChangeableId(Long id, String operation) {
        if (UNCHANGEABLE_ALUNO_ID.equals(id)) {
            throw new BusinessException("OPS! student  ID %d not is %s.".formatted(UNCHANGEABLE_ALUNO_ID, operation));
        }
    }*/

}
