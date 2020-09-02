'use strict'
/**
 * @author BookApp-Devs
 */
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database')

class LivrosVenda extends Model {

    Adicionar( dados ) {
        return database.
                 raw('call STPLIVROS_VENDA_INSERT_UPDATE(?,?,?,?,?,?)', dados)
    }

    ListarLivrosAVenda( ) {
        return  database
            .raw('SELECT `livros_venda`.`pkLivroVenda`,`livros_venda`.`fkLivro`,`livros_venda`.`nomeLivro`,`livros_venda`.`fkUsuario`,`livros_venda`.`usuario`,`livros_venda`.`preco`,`livros_venda`.`data_pub_venda`,`livros_venda`.`status_` FROM `bookapp`.`livros_venda` limit 100;');     
         }
}

module.exports = LivrosVenda
