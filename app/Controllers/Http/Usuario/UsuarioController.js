"use strict";
/**autor : BookApp-Devs */
const Usuario = use("App/Models/Usuario/Usuario");
const UsuarioModel = new Usuario();
const toJson = use("App/Helpers/Json");
const Helpers = use("Helpers");
const crypto = require("crypto");

class UsuarioController {
  /**
   *
   * @param {*} param0
   */

  async ListarUsuarios({ response, request }) {
    let result = await UsuarioModel.ListarUsuarios(); //inserindo os dados
    let formatoJson = toJson.Create(result);
    response.json(formatoJson);
  }


  async avatar({ response, request }) {

    let errorResponse = toJson.generate(204, "error", " ", {});

    try {
     
    response.send({status:"working"})
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

  async changeAvatar({ response, request }) {
    let errorResponse = toJson.generate(204, "error", " ", {});

    try {
      const idUsuario = request.user.id;
      const { tipoUsuario } = request.body;

      const avatar = request.file("avatar", {
        types: ["image"],
        size: "2mb",
      });

      //Encriptar userID e tipoUsuario no nome da imagem
      const { extname } = avatar;

      const str = `avatar_${idUsuario}_${tipoUsuario}`;

      const name = crypto.createHash("md5").update(String(str)).digest("hex");

      const imgName = `${name}.jpg`;
      await avatar.move(Helpers.tmpPath("uploads/users_avatar"), {
        name: imgName,
        overwrite: true,
      });

      if (!avatar.moved()) {
        let error = avatar.error();

        console.log({ ERROR: error });
        errorResponse.message = "Error during change avatar";
        errorResponse.code = 204;
        return response.json(errorResponse);
      }

      const dados = [idUsuario, tipoUsuario, imgName];

      let result = await UsuarioModel.changeAvatar(dados);

      if (result[0].affectedRows >= 2) {
        console.log(result);

        let successResponse = toJson.generate(
          202,
          "success",
          "Avatar changed",
          {}
        );
        return response.json(successResponse);
      }

      console.log(result);
      errorResponse.message =
        "Error during change avatar, data base update error";
      errorResponse.code = 204;
      return response.json(errorResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

  async follow({ response, request }) {
    let errorResponse = toJson.generate(204, "error", " ", {});

    try {
      let idSeguidor = request.user.id;
      let { id_seguindo, avatar, username } = request.body;
      const dados = [idSeguidor, id_seguindo, avatar, username];

      let result = await UsuarioModel.follow(dados);

      if (result[0].affectedRows > 0) {
        let successResponse = toJson.generate(202, "success", "Following", {});
        return response.json(successResponse);
      }
      console.log(result);
      errorResponse.message = "Error trying to follow";
      errorResponse.code = 204;
      return response.json(errorResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

  async unFollow({ response, request }) {
    let errorResponse = toJson.generate(204, "error", " ", {});

    try {
      let id_seguidor = request.user.id;

      let result = await UsuarioModel.unFollow(id_seguidor);

      if (result[0].affectedRows > 0) {
        let successResponse = toJson.generate(
          202,
          "success",
          "User has unfollowed",
          {}
        );
        return response.json(successResponse);
      }
      console.log(result);
      errorResponse.message = "Error trying to unfollow";
      errorResponse.code = 204;
      return response.json(errorResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

  async getFollowers({ response, request }) {
    let errorResponse = toJson.generate(
      204,
      "error",
      "Error getting followers ",
      {}
    );
    try {
      let { id_seguindo } = request.body;

      let result = await UsuarioModel.getFollowers(id_seguindo); //inserindo os dados

      let successResponse = toJson.generate(
        201,
        "success",
        "Listing followers",
        result[0]
      );
      return response.json(successResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.code = 500;
      errorResponse.message = "Server error ";
      return response.status(500).json(errorResponse);
    }
  }

  async userPhoneExists({ response, request }) {
    let errorResponse = toJson.generate(
      204,
      "error",
      "Error verifying phone ",
      {}
    );

    try {
      let { phone } = request.body;

      let userPhoneExist = await UsuarioModel.userPhoneExists(phone);

      console.log(userPhoneExist);

      let { qtdPhone } = userPhoneExist[0][0];

      if (qtdPhone > 0) {
        errorResponse.message = "Phone already exists";
        errorResponse.code = 202;
        return response.json(errorResponse);
      }

      let successResponse = toJson.generate(
        201,
        "success",
        "Phone does not exist",
        {}
      );
      return response.json(successResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

  async userEmailExists({ response, request }) {
    let errorResponse = toJson.generate(
      204,
      "error",
      "Error verifying e-mail ",
      {}
    );

    try {
      let { email } = request.body;

      let userEmailExist = await UsuarioModel.userEmailExists(email);

      console.log(userEmailExist);

      let { qtdEmail } = userEmailExist[0][0];

      if (qtdEmail > 0) {
        errorResponse.message = "E-mail already exists";
        errorResponse.code = 203;
        return response.json(errorResponse);
      }

      let successResponse = toJson.generate(
        201,
        "success",
        "E-mail does not exist",
        {}
      );
      return response.json(successResponse);
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }
}

module.exports = UsuarioController;
