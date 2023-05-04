library(readxl)
library(tidyverse)
dados_radar_ppp <- read_excel("BD_RadarPPP_2023_02_01.xlsx",
                                     col_types = c("text", "text", "text",
                                                   "text", "text", "text", "date",
                                                   "text", "text", "text", "text", "text",
                                                   "text", "text", "text", "text", "text",
                                                   "text", "date", "text", "numeric"))

dados_radar_ppp<- janitor::clean_names(dados_radar_ppp)


#tratamento das colunas de ressarcimentos

dados_radar_ppp_trabalho<-
dados_radar_ppp %>%
  mutate(atingiu_teto_ressarcimento_reais = ifelse(stringr::str_detect(ressarcimento_estudos_reais, "Teto de "),"sim","não")) %>%
  mutate(ressarcimento_estudos_reais= ifelse(stringr::str_detect(ressarcimento_estudos_reais, "Teto de "),
                                             stringr::str_sub(ressarcimento_estudos_reais,9,30),
                                             ressarcimento_estudos_reais)) %>%
  mutate(ressarcimento_estudos_reais= stringr::str_replace_all(ressarcimento_estudos_reais,"[.]","")) %>%
  mutate(ressarcimento_estudos_reais= stringr::str_replace_all(ressarcimento_estudos_reais,"[,]",".")) %>%
  mutate(ressarcimento_estudos_reais= as.numeric(ressarcimento_estudos_reais)) %>%
  mutate(atingiu_teto_ressarcimento_dolares = ifelse(stringr::str_detect(ressarcimento_estudos_dolares, "Teto de "),"sim","não")) %>%
  mutate(ressarcimento_estudos_dolares= ifelse(stringr::str_detect(ressarcimento_estudos_dolares, "Teto de "),
                                             stringr::str_sub(ressarcimento_estudos_dolares,9,30),
                                             ressarcimento_estudos_dolares)) %>%
  mutate(ressarcimento_estudos_dolares= stringr::str_replace_all(ressarcimento_estudos_dolares,"[,]","")) %>%
  mutate(ressarcimento_estudos_dolares= stringr::str_replace_all(ressarcimento_estudos_dolares,"[.]",".")) %>%
  mutate(ressarcimento_estudos_dolares= as.numeric(ressarcimento_estudos_dolares))
