# Analiza sentymentu wypowiedzi kandydatów

## Co robi ten skrypt?

1. **Wczytuje pliki tekstowe** z wypowiedziami poszczególnych kandydatów
2. **Dzieli tekst na segmenty** o ustalonej długości dla analizy czasowej
3. **Przeprowadza analizę sentymentu** używając 5 różnych słowników językowych
4. **Analizuje emocje** w tekście według słownika NRC
5. **Tworzy wizualizacje** porównawcze sentymentu
6. **Analizuje zmiany sentymentu w czasie** z wykresami liniowymi i wygładzonymi

## Używane słowniki sentymentu

### General Inquirer (GI)
- Słownik ogólnego zastosowania
- Zawiera słowa pozytywne i negatywne 

### Henry's Financial (HE)
- Słownik finansowy

### Loughran-McDonald
- Finansowy słownik Loughran-McDonald
- Zawiera słowa pozytywne, negatywne oraz związane z niepewnością

### QDAP
- Słownik do analizy dyskursu
- Zawiera słowa pozytywne i negatywne

### NRC
- Słownik emocji NRC
- Analizuje 8 podstawowych emocji: gniew, strach, przewidywanie, zaufanie, radość, smutek, obrzydzenie, zaskoczenie

## Kandydaci do analizy

Skrypt można uruchomić dla każdego z kandydatów z debaty:
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

