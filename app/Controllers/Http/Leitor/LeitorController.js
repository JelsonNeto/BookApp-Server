'use strict'
const leitor = use('App/Models/Leitor/Leitor') //
const leitorModel = new leitor()
class LeitorController {
    async Adicionar({response}) {
        let dados = [0, 'Diocleciano Donga','34567','Teste','Dio@gmail.com' , '934567891','1234','asfh']
        let result = await leitorModel.Adicionar(dados)
        
        response.json(result)
     }
    }

module.exports = LeitorController
