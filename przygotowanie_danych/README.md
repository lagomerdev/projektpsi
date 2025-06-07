# Pipeline do przygotowania danych tesktowych z debaty

## Co robi ten pipeline?

1. **Pobiera napisy** z filmu YouTube za pomocą yt-dlp
2. **Konwertuje napisy** z formatu JSON3 do czystego JSON
3. **Łączy tekst** w jeden plik tekstowy
4. **Tłumaczy** z polskiego na angielski używając LLM
5. **Identyfikuje rozmówców** - rozpoznaje kto kiedy mówi w debacie uzywając LLM
6. **Tworzy pliki rozmówców** - tworzy pliki rozmówców 

## Kandydaci w debacie

- Krzysztof Stanowski
- Joanna Senyszyn  
- Marek Woch
- Marek Jakubiak
- Artur Bartoszewicz
- Magdalena Biejat
- Karol Nawrocki
- Rafał Trzaskowski
- Szymon Hołownia
- Maciej Maciak
- Adrian Zandberg
- Grzegorz Braun
- Sławomir Mentzen

## Wyniki

Projekt tworzy:
- `debata.json` - napisy w formacie JSON
- `debata.txt` - pełny tekst debaty
- `debata_translated.txt` - tłumaczenie na angielski
- `debate_speakers.json` - identyfikacja rozmówców
- `speaker_[nazwa].txt` - pliki z wypowiedziami każdego kandydata 