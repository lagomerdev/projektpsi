



# Analiza sentymentu w czasie ----

library(SentimentAnalysis)
library(ggplot2)
library(ggthemes)
library(tidyverse)
library(syuzhet)



# Jeden cały plik ----

# Wczytanie danych tekstowych
# Odczytanie lokalnego pliku .txt
text <- readLines('nazwa sciezki do dokumentu txt kandydata', encoding="UTF-8")



# Podział tekstu na równe segmenty o ustalonej długości ----


# Usunięcie pustych wierszy
non_empty_lines <- text[nzchar(text)]


# Połączenie wszystkich wierszy w jeden ciąg znaków
full_text <- paste(non_empty_lines, collapse = " ")

# Usunięcie zbędnych spacji
full_text <- gsub("\\s+", " ", full_text)

# Funkcja do dzielenia tekstu na segmenty o określonej długości
split_text_into_chunks <- function(text, chunk_size) {
  start_positions <- seq(1, nchar(text), by = chunk_size)
  chunks <- substring(text, start_positions, start_positions + chunk_size - 1)
  return(chunks)
}

# Podzielenie tekstu na segmenty
#
# ustaw min_lentgh jako jednolitą długość jednego segmentu
min_length <- 50
text_chunks <- split_text_into_chunks(full_text, min_length)


# Wyświetlenie wynikowych segmentów
# print(text_chunks)



# Analiza sentymentu przy użyciu pakietu SentimentAnalysis ----
sentiment <- analyzeSentiment(text_chunks)


# odkomentuj i zobacz parametry funkcji:
# ?analyzeSentiment




### Słownik GI (General Inquirer) ----
#
# Słownik ogólnego zastosowania
# zawiera listę słów pozytywnych i negatywnych
# zgodnych z psychologicznym słownikiem harwardzkim Harvard IV-4
# DictionaryGI


# Wczytaj słownik GI
data(DictionaryGI)
summary(DictionaryGI)


# Konwersja ciągłych wartości sentymentu 
# na odpowiadające im wartości kierunkowe 
# zgodnie ze słownikiem GI
sentimentGI <- convertToDirection(sentiment$SentimentGI)


# Wykres skumulowanego sentymentu kierunkowego
plot(sentimentGI)


# Ten sam wykres w ggplot2:
# Konwersja do ramki danych (ggplot wizualizuje ramki danych)
df_GI <- data.frame(index = seq_along(sentimentGI), value = sentimentGI, Dictionary = "GI")

# Usunięcie wierszy, które zawierają NA
df_GI <- na.omit(df_GI)

ggplot(df_GI, aes(x = value)) +
  geom_bar(fill = "green", alpha = 0.7) + 
  labs(title = "Skumulowany sentyment (GI)",
       x = "Sentyment",
       y = "Liczba") +
  theme_bw()



### Analiza emocji wedlug slownika NRC
nrc_emotions <- get_nrc_sentiment(text_chunks)

# Sumowanie emocji w całym tekście
emotion_totals <- colSums(nrc_emotions[, 1:8])  # tylko emocje, bez pos/neg

# Zamiana na ramkę danych
emotion_df <- data.frame(
  emotion = names(emotion_totals),
  count = as.numeric(emotion_totals)
)

# Wykres emocji
ggplot(emotion_df, aes(x = reorder(emotion, -count), y = count, fill = emotion)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Najczęstsze emocje według słownika NRC",
       x = "Emocja", y = "Liczba wystąpień") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
### Słownik HE (Henry’s Financial dictionary) ----
#
# zawiera listę słów pozytywnych i negatywnych
# zgodnych z finansowym słownikiem "Henry 2008"
# pierwszy, jaki powstał w wyniku analizy komunikatów prasowych 
# dotyczących zysków w branży telekomunikacyjnej i usług IT
# DictionaryHE


# Wczytaj słownik HE
data(DictionaryHE)
summary(DictionaryHE)


# Konwersja ciągłych wartości sentymentu 
# na odpowiadające im wartości kierunkowe 
# zgodnie ze słownikiem HE
sentimentHE <- convertToDirection(sentiment$SentimentHE)


# Wykres skumulowanego sentymentu kierunkowego
plot(sentimentHE)


# Ten sam wykres w ggplot2:
# Konwersja do ramki danych (ggplot wizualizuje ramki danych)
df_HE <- data.frame(index = seq_along(sentimentHE), value = sentimentHE, Dictionary = "HE")

# Usunięcie wierszy, które zawierają NA
df_HE <- na.omit(df_HE)

ggplot(df_HE, aes(x = value)) +
  geom_bar(fill = "blue", alpha = 0.7) + 
  labs(title = "Skumulowany sentyment (HE)",
       x = "Sentyment",
       y = "Liczba") +
  theme_bw()




### Słownik LM (Loughran-McDonald Financial dictionary) ----
#
# zawiera listę słów pozytywnych i negatywnych oraz związanych z niepewnością
# zgodnych z finansowym słownikiem Loughran-McDonald
# DictionaryLM


# Wczytaj słownik LM
data(DictionaryLM)
summary(DictionaryLM)


# Konwersja ciągłych wartości sentymentu 
# na odpowiadające im wartości kierunkowe 
# zgodnie ze słownikiem LM
sentimentLM <- convertToDirection(sentiment$SentimentLM)


# Wykres skumulowanego sentymentu kierunkowego
plot(sentimentLM)


# Ten sam wykres w ggplot2:
# Konwersja do ramki danych (ggplot wizualizuje ramki danych)
df_LM <- data.frame(index = seq_along(sentimentLM), value = sentimentLM, Dictionary = "LM")

# Usunięcie wierszy, które zawierają NA
df_LM <- na.omit(df_LM)

ggplot(df_LM, aes(x = value)) +
  geom_bar(fill = "orange", alpha = 0.7) + 
  labs(title = "Skumulowany sentyment (LM)",
       x = "Sentyment",
       y = "Liczba") +
  theme_bw()




### Słownik QDAP (Quantitative Discourse Analysis Package) ----
#
# zawiera listę słów pozytywnych i negatywnych
# do analizy dyskursu


# Wczytaj słownik QDAP
qdap <- loadDictionaryQDAP()
summary(qdap)


# Konwersja ciągłych wartości sentymentu 
# na odpowiadające im wartości kierunkowe 
# zgodnie ze słownikiem QDAP
sentimentQDAP <- convertToDirection(sentiment$SentimentQDAP)


# Wykres skumulowanego sentymentu kierunkowego
plot(sentimentQDAP)


# Ten sam wykres w ggplot2:
# Konwersja do ramki danych (ggplot wizualizuje ramki danych)
df_QDAP <- data.frame(index = seq_along(sentimentQDAP), value = sentimentQDAP, Dictionary = "QDAP")

# Usunięcie wierszy, które zawierają NA
df_QDAP <- na.omit(df_QDAP)

ggplot(df_QDAP, aes(x = value)) +
  geom_bar(fill = "red", alpha = 0.7) + 
  labs(title = "Skumulowany sentyment (QDAP)",
       x = "Sentyment",
       y = "Liczba") +
  theme_bw()



# Porównanie sentymentu na podstawie różnych słowników ----


# Połączenie poszczególnych ramek w jedną ramkę

# Oblicz sentyment NRC dla każdego segmentu
nrc_scores <- get_nrc_sentiment(text_chunks)

# Oblicz ogólny sentyment jako różnicę pozytywnych i negatywnych emocji
nrc_sentiment <- nrc_scores$positive - nrc_scores$negative


df_all <- bind_rows(df_GI, df_HE, df_LM, df_QDAP)

# df_all i nrc_sentiment muszą mieć tę samą długość
df_all$NRC <- nrc_sentiment

# Konwersja wartości NRC do kategorii (positive, negative, neutral)
nrc_dir <- ifelse(nrc_sentiment > 0, "positive",
                  ifelse(nrc_sentiment < 0, "negative", "neutral"))

df_NRC <- data.frame(Dictionary = "NRC", value = nrc_dir)

# Dodanie do wspólnej ramki
df_all_dicts <- bind_rows(df_GI, df_HE, df_LM, df_QDAP, df_NRC)

# Nowy wykres z NRC
ggplot(df_all_dicts, aes(x = value, fill = Dictionary)) +
  geom_bar(alpha = 0.7) + 
  labs(title = "Skumulowany sentyment według słowników (z NRC)",
       x = "Sentyment",
       y = "Liczba") +
  theme_bw() +
  facet_wrap(~Dictionary) +
  scale_fill_manual(values = c("GI" = "green", 
                               "HE" = "blue", 
                               "LM" = "orange",
                               "QDAP" = "red",
                               "NRC" = "purple"))




# Agregowanie sentymentu z różnych słowników w czasie ----


# — Przygotowanie time series z NRC — 


# Oblicz NRC jako różnicę pozytywnych i negatywnych emocji
nrc_scores    <- get_nrc_sentiment(text_chunks)
nrc_sentiment <- nrc_scores$positive - nrc_scores$negative

# Stwórz osobną ramkę na potrzeby wykresu czasowego
df_time <- data.frame(
  sentence = seq_along(text_chunks),
  GI   = sentiment$SentimentGI,
  HE   = sentiment$SentimentHE,
  LM   = sentiment$SentimentLM,
  QDAP = sentiment$SentimentQDAP,
  NRC  = nrc_sentiment
)

# Usuń wiersze z NA (zwłaszcza w QDAP)
df_time <- df_time[complete.cases(df_time), ]

# — Wykres liniowy (surowe wartości) —
ggplot(df_time, aes(x = sentence)) +
  geom_line(aes(y = QDAP), color = "red",    size = 1) +
  geom_line(aes(y = GI),   color = "green",  size = 1) +
  geom_line(aes(y = HE),   color = "blue",   size = 1) +
  geom_line(aes(y = LM),   color = "orange", size = 1) +
  geom_line(aes(y = NRC),  color = "purple", size = 1) +
  labs(
    title = "Zmiana sentymentu w czasie (z NRC)",
    x     = "Oś czasu zdań",
    y     = "Sentyment"
  ) +
  theme_gdocs()

# — Wykres wygładzony —
ggplot(df_time, aes(x = sentence)) +
  geom_smooth(aes(y = QDAP), color = "red") +
  geom_smooth(aes(y = GI),   color = "green") +
  geom_smooth(aes(y = HE),   color = "blue") +
  geom_smooth(aes(y = LM),   color = "orange") +
  geom_smooth(aes(y = NRC),  color = "purple") +
  labs(
    title = "Wygładzona zmiana sentymentu w czasie (z NRC)",
    x     = "Oś czasu zdań",
    y     = "Sentyment"
  ) +
  theme_gdocs()




