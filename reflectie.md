## Reflectie - Data Persistency

### Vragen doorheen de periode:
~~1. Hoe extra rij toevoegen~~  
~~2. Data uit trowgenerator koppelen aan datum dim~~
3. de afstand berekenen gewoon in sql ?  
4. Hoe rekening houden met SCD in fact ? (nu met active == true)  


## Milestone #1
### Vooruitgang (voor feedbackmoment)
Transformatie was even zoeken. Elementen met dezelfde naam (simpledata) maakte het moeilijker om deze te selecteren.  
De dimensies zijn, na het volgen van de tutorial videos, toch ingewikkeld. Het is even wennen aan het DI programma Talend. De Date en lock Dimensie gingen goed. Voor het weer was het even zoeken wat er precies gevraagd werd. Ook het toevoegen van een extra rij bij Locks en Weather was even zoeken hoe je dit kon doen met tRowGenerator of een excel en deze mergen met de tmap uit de operational server. De SCD van Customers was ook duidelijk door de tutorial.
We zijn ook al aan de fact gekomen en hier zijn we op heel veel null data gestoten, we weten ook niet goed hoe we lookup moeten doen naar de Weather dimensie adhv de geschiedenis. Ook de duurtijd van de rides is negatief omdat het startpunt (2015) na het eindpunt (2012) ligt.  

** Struikelblokken:  **
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
### Zelfreflectie (na feedbackmoment)
**Wat gaat er goed en minder goed**  
  
**Todo's**  
  
**Advies en waarschuwingen**  
  

## Milestone #2
### Vooruitgang (voor feedbackmoment)
### Zelfreflectie (na feedbackmoment)
**Wat gaat er goed en minder goed**  
  
**Todo's**  
  
**Advies en waarschuwingen**  

## Milestone #3 : Examen
### Vooruitgang (voor feedbackmoment)
### Zelfreflectie
**Wat gaat er goed en minder goed**  
  
**Todo's**  
  
**Advies en waarschuwingen**  

