# TUTORIAL: - CHANGE INSERT_LOCO_KEY TO KEY FROM LOCO
# Eliminate languages that are not used or add new ones in case you need

mkdir -p lib/commons/services/translation/l10n

touch lib/commons/services/translation/l10n/intl_es.arb
touch lib/commons/services/translation/l10n/intl_en.arb

curl -XGET 'https://localise.biz:443/api/export/locale/es-ES.arb?key=INSERT_LOCO_KEY' > lib/commons/services/translation/l10n/intl_es.arb
curl -XGET 'https://localise.biz:443/api/export/locale/pt-BR.arb?key=INSERT_LOCO_KEY' > lib/commons/services/translation/l10n/intl_en.arb

dart run intl_utils:generate