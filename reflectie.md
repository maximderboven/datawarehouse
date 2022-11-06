## Reflectie - Data Persistency

### Vragen doorheen de periode:
~~1. Hoe extra rij toevoegen~~  
~~2. Data uit trowgenerator koppelen aan datum dim~~  
~~3. de afstand berekenen gewoon in sql ?~~  
~~4. Hoe rekening houden met SCD in fact ? (nu met active == true)~~  


## Milestone #1
### Vooruitgang (voor feedbackmoment)
Transformatie was even zoeken. Elementen met dezelfde naam (simpledata) maakte het moeilijker om deze te selecteren.  
De dimensies zijn, na het volgen van de tutorial videos, toch ingewikkeld. Het is even wennen aan het DI programma Talend. De Date en lock Dimensie gingen goed. Voor het weer was het even zoeken wat er precies gevraagd werd. Ook het toevoegen van een extra rij bij Locks en Weather was even zoeken hoe je dit kon doen met tRowGenerator of een excel en deze mergen met de tmap uit de operational server. De SCD van Customers was ook duidelijk door de tutorial.
We zijn ook al aan de fact gekomen en hier zijn we op heel veel null data gestoten, we weten ook niet goed hoe we lookup moeten doen naar de Weather dimensie adhv de geschiedenis. Ook de duurtijd van de rides is negatief omdat het startpunt (2015) na het eindpunt (2012) ligt.  

**Struikelblokken:**
- Varbinary ipv image bij de start en endpoint van de fact  
- Aanmaken van de SCD tabel zelf in de sql server  
- Alleen Inline Ifs lukken op expressions   
- Opzoeken van de dimWeather type met de weather data in dezelfde tmap  
- Uitzoeken van de API openweather inladen in talend was ook een gedoe  
- Soms moeilijk om bij elke component de kolommen overeen te laten komen aangezien je die overal kunt aanpassen  
- 1 rij erbij krijgen en mergen  
- 1 rij bij locks dimensie met slot was ook onduidelijk (uiteindelijk gewoon allemaal NULL waarden in gemaakt en additional info)  
- Bij de backup zat al user DB3 zonder password, maar talend aanvaard geen users zonder login.  
- De Context vars waren even zoeken omdat ze pas op het einde vermeld werden   

**Status:**  
Transformatie: 90%  
ETL DWH Dimensies: 85%  
ETL DWH Feit & Analyse: 55%  
Optimalisatie: 0%  
NOSQL Databank: 0%  
### Zelfreflectie (na feedbackmoment)   
**Reflectie**  
Zeker de fact tabel nog eens bekijken en opsplitsen, aantal vragen zijn beantwoord en zijn nu duidelijker. We waren goed bezig, dit tempo vasthouden.  

**Todo's, Advies en waarschuwingen**  
*Transformatie (xsl):*  
join maken en tabel maken om te vergelijken, en kijken of het er 301 zijn  
wordt it die placemark count niet overgeslagen na een if  
for loop met condition voor counter bij te houden ipv placemark  

*DWH (dimensies):*  
Alle dimensies waren in orde

*DWH (feit):*  
De koppeling tussen feit en dimCustomers kun je nog beter maken door start en eind datum van de rit tussen de subscription als expressie te gebruiken  
De koppeling tussen feit (weatherhistory) en dimWeather mag je gewoon met de fk doen  
Feit tabel opspliten met koppeling (FKs) tussen dimensies.  
Er ontbreken ook enkele waarden (NULL) die er niet mogen zijn.  
Analysevragen beantwoorden mag met SQL statement  
Afstandberekenen mag in het SELECT statement  


## Milestone #2
### Vooruitgang (voor feedbackmoment)
Na de vorige feedback zijn we aan de slag gegaan met de verkregen informatie. De joins op datums waren een behoorlijk probleem. Hiervoor hebben we een vraag gesteld en hebben we dit samen met de docent bekeken. De uiteindelijk conslusie was om de datums gewoon als string te vergelijken. De analyse queries verliepen ook soepel. Deze waren een beetje te vaag dus deze hebben we te veel uitgewerkt.  

Verder was Maxim naar budapest in week 5 voor een project voor het vak technologie en samenleving. Gelukkig hadden we al enige voorsprong om deze week op te vangen. Voor vertrek hebben we de optimalisatie technieken samen bekeken. Bij terugkomst zouden we deze implementeren. In W5 is Jonas al begonnen aan de NOSQL case van mongodb.  

**Struikelblokken:**
- Datums vergelijken in Talend  
- Afstand berekenen telkens in SQL statement

**Status:**  
Transformatie: 90%  
ETL DWH Dimensies: 95%  
ETL DWH Feit & Analyse: 95%  
Optimalisatie: 50%  
NOSQL Databank: 20%  

### Zelfreflectie (na feedbackmoment)   
**Reflectie**  
Ondanks de gemiste week zitten we toch op schema.  

**Todo's, Advies en waarschuwingen**  
*DWH (feit & analysevragen):*  
Agregatie op POINTS is niet nodig, inlezen van de distance kan meteen in de fact. Start en endpoint zijn geen Measure values.  



## Milestone #3 : Examen
### Vooruitgang (voor feedbackmoment)  
Uitgebreide documentatie voor optimalisatie. NOSQL in elasticsearch was een opgave om uit te zoeken. Data inlezen is door middel van een csv export en zou eventueel automatisch kunnen met JDBC. Elastic search heeft een uitgebreid aanbod aan opties en met zo een beknopte opagave is het niet duidelijk wat er juist verwacht wordt. Doordat ik een week ben weg geweest naar Hongarije heb ik ook een hoop uitleg gemist.  
Voor de opleveringen hebben we alles nog een van 0 uitgevoerd om er zeker van te zijn dat alles werkt. Hier kwamen we nog een fout tegen in de transformatie. Deze hebben we dan ook opgelost.  
We hebben nog heel wat werk verzet voor deze milestone. Het was een hele opgave maar we hebben het naar onze mening goed volbracht. 
  
  
### Zelfreflectie (na feedbackmoment)   
**Reflectie**  
  
**Todo's, Advies en waarschuwingen**  
