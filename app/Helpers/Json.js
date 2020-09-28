/**
 * autor:BookApp-Devs
 * Descrição : Este objecto será responsável por formatar as saidas das requisições...
 * Nota: Em desenvolvimento
 */
const toJson = {

    Create( results ) {
         if(results.length){
             if(results[0].affectedRows !== null) //verifica se a inserção foi feita com sucesso
              return  this.SucessInsert(results[0])
         }
    },

    SucessInsert(results) {
     
        let format = 
        {
            code:201,
            status:'Ok',
            message:'Inserção feita com sucesso',
            data:results
        }
        return format
    },

    generate(code,status,message,data){
        let format = 
        {
            code,
            status,
            message,
            data
        }
        return format


    }

}

module.exports = toJson