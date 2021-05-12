import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = 'http://192.168.2.26';

stGetKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    return value;
}

stSetKey(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
}

const List WEEK_DAY = [ "Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sabado" ];

const Map STATUS_MSG = {
    100: "continuar",
    101: "mudando Protocolos",
    102: "processando",
    200: "ok",
    201: "criado",
    202: "aceito",
    203: "não autorizado",
    204: "nenhum Conteúdo",
    205: "resetar Conteúdo",
    206: "conteúdo Parcial",
    300: "múltipla Escolha",
    301: "movido Permanentemente",
    302: "encontrado",
    303: "veja outro",
    304: "não modificado",
    305: "use Proxy",
    306: "proxy Trocado",
    400: "solicitação Inválida",
    401: "não autorizado",
    402: "pagamento necessário",
    403: "proibido",
    404: "não encontrado",
    405: "método não permitido",
    406: "não aceito",
    407: "autenticação de Proxy Necessária",
    408: "tempo de solicitação esgotado",
    409: "conflito",
    410: "perdido",
    411: "duração necessária",
    412: "falha de pré-condição",
    413: "solicitação da entidade muito extensa",
    414: "solicitação de URL muito Longa",
    415: "tipo de mídia não suportado",
    416: "solicitação de faixa não satisfatória",
    417: "falha na expectativa",
    500: "erro do Servidor Interno",
    501: "não implementado",
    502: "porta de entrada ruim",
    503: "serviço indisponível",
    504: "erro na conexão com o servidor",
    505: "versão HTTP não suportada"
};
