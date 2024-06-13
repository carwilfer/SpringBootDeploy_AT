package com.infnet.escola_AT_Dr1.model;

import jakarta.persistence.Id;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "alunos")
@Data
@Getter
@Setter
public class Aluno {
    @Id
    private String id;
    private String nome;
    private String cpf;
    private String email;
    private String telefone;
    private String endereco;
}
