import 'package:flutter/material.dart';

class CityDescription extends ChangeNotifier {
  final List _cityDescription = [
    ' Milan is the capital city of the region of Lombardy in northern Italy. It is the second largest city by population in Italy, behind Rome. It is Italy\'s leading financial centre and its most prosperous manufacturing and commercial city.',
    'Rome (Italian and Latin: Roma), the Eternal City, is the capital and largest city of Italy and of the Lazio region. It\'s the famed city of the Roman Empire, the Seven Hills, La Dolce Vita, the Vatican City and Three Coins in the Fountain.',
    'Bologna, Latin Bononia, city, capital of Emilia-Romagna region, in northern Italy, north of Florence, between the Reno and Savena rivers. It lies at the northern foot of the Apennines, on the ancient Via Aemilia, 180 ft (55 metres) above sea level.',
    'Paris, France\'s capital, is a major European city and a global center for art, fashion, gastronomy and culture. Its 19th-century cityscape is crisscrossed by wide boulevards and the River Seine.',
    'Madrid, Spain\'s central capital, is a city of elegant boulevards and expansive, manicured parks such as the Buen Retiro. It\'s renowned for its rich repositories of European art, including the Prado Museum\'s works by Goya, Velazquez and other Spanish masters.',
    'Cape Town is a port city on South Africa\'s southwest coast, on a peninsula beneath the imposing Table Mountain. Slowly rotating cable cars climb to the mountain\'s flat top, from which there are sweeping views of the city, the busy harbor and boats heading for Robben Island, the notorious prison that once held Nelson Mandela, which is now a living museum.',
    'New York City comprises 5 boroughs sitting where the Hudson River meets the Atlantic Ocean. At its core is Manhattan, a densely populated borough that\'s among the world\'s major commercial, financial and cultural centers.',
    'California, a western U.S. state, stretches from the Mexican border along the Pacific for nearly 900 miles. Its terrain includes cliff-lined beaches, redwood forest, the Sierra Nevada Mountains, Central Valley farmland and the Mojave Desert. The city of Los Angeles is the seat of the Hollywood entertainment industry',
    'São Paulo, Brazil\'s vibrant financial center, is among the world\'s most populous cities, with numerous cultural institutions and a rich architectural tradition. Its iconic buildings range from its neo-Gothic cathedral and the 1929 Martinelli skyscraper to modernist architect Oscar Niemeyer\'s curvy Edificio Copan. ',
    'Shanghai, on China\'s central coast, is the country\'s biggest city and a global financial hub. Its heart is the Bund, a famed waterfront promenade lined with colonial-era buildings. Across the Huangpu River rises the Pudong district\'s futuristic skyline, including 632m Shanghai Tower and the Oriental Pearl TV Tower, with distinctive pink spheres.'
  ];

  // get method for city description

  get cityDescription => _cityDescription;
}
