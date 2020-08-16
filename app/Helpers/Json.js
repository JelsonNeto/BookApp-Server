/**
 * autor:BookApp-Devs
 * Descrição : Este objecto será responsável por formatar as saidas das requisições...
 * Nota: Em desenvolvimento
 */
const toJson = {

    Create( results ) {
         if(results.length){
             if(results[0].affectedRows !== null) //verifica se a inserção foi feita com sucesso
              return  this.SucessInsert()
         }
    },

    SucessInsert() {
        let format = 
        {
            code:201,
            status:'Ok',
            message:'Livraria inserida com sucesso',
            data:''
        }
        return format
    }

}

module.exports = toJson