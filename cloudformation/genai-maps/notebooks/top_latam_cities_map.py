import folium
import pandas as pd
from random import randint, choice

# Create DataFrame with top 10 most visited cities in Latin America
data = {
    'rank': range(1, 11),
    'city': ['Mexico City', 'Buenos Aires', 'Rio de Janeiro', 'Lima', 'São Paulo', 
             'Punta Cana', 'Cancun', 'Bogotá', 'Santiago', 'Cusco'],
    'country': ['Mexico', 'Argentina', 'Brazil', 'Peru', 'Brazil', 
                'Dominican Republic', 'Mexico', 'Colombia', 'Chile', 'Peru'],
    'visitors_millions': [11.9, 6.8, 6.3, 5.4, 4.8, 
                          4.5, 4.3, 3.9, 3.7, 3.5],
    'latitude': [19.4326, -34.6037, -22.9068, -12.0464, -23.5505, 
                 18.5821, 21.1619, 4.7110, -33.4489, -13.5319],
    'longitude': [-99.1332, -58.3816, -43.1729, -77.0428, -46.6333, 
                  -68.4039, -86.8515, -74.0721, -70.6693, -71.9675]
}

df = pd.DataFrame(data)

def get_sample_weather():
    """Generate sample weather data"""
    weather_conditions = [
        'Clear sky', 'Partly cloudy', 'Sunny', 'Light rain',
        'Cloudy', 'Scattered clouds', 'Moderate rain'
    ]
    return {
        'temp': randint(18, 35),  # Temperature between 18-35°C
        'description': choice(weather_conditions),
        'humidity': randint(50, 95)
    }

# Create a map centered on Latin America
m = folium.Map(location=[0, -70], zoom_start=3, tiles='CartoDB positron')

# Add markers to the map
for idx, row in df.iterrows():
    # Get sample weather
    weather = get_sample_weather()
    
    # Create popup content with styled HTML
    popup_content = f"""
    <div style="font-family: Arial; padding: 5px;">
        <h3 style="color: #2c3e50; margin-bottom: 5px;">{row['city']}, {row['country']}</h3>
        <div style="background-color: #f8f9fa; padding: 10px; border-radius: 5px;">
            <p style="margin: 5px 0;"><b>🏆 Rank:</b> #{row['rank']}</p>
            <p style="margin: 5px 0;"><b>👥 Visitors:</b> {row['visitors_millions']} million</p>
            <div style="margin-top: 10px; border-top: 1px solid #dee2e6; padding-top: 10px;">
                <p style="margin: 5px 0;"><b>🌡️ Temperature:</b> {weather['temp']}°C</p>
                <p style="margin: 5px 0;"><b>🌤️ Conditions:</b> {weather['description']}</p>
                <p style="margin: 5px 0;"><b>💧 Humidity:</b> {weather['humidity']}%</p>
            </div>
        </div>
    </div>
    """
    
    # Create marker with custom icon
    folium.Marker(
        location=[row['latitude'], row['longitude']],
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"{row['rank']}. {row['city']}, {row['country']}",
        icon=folium.Icon(color='red' if row['rank'] <= 3 else 'blue', 
                         icon='info-sign')
    ).add_to(m)

# Add title with styled HTML
title_html = '''
<div style="position: fixed; 
            top: 10px; left: 50px; 
            width: 320px; 
            background-color: white; 
            border-radius: 10px;
            border: 2px solid grey; 
            z-index: 9999; 
            padding: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <h3 style="margin: 0; color: #2c3e50; text-align: center;">
        Top 10 Most Visited Cities in Latin America
    </h3>
    <p style="margin: 5px 0 0; font-size: 12px; color: #666; text-align: center;">
        Click on markers to see details
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(title_html))

# Save the map
m.save('top_latam_cities_map.html')

print("Map has been created as 'top_latam_cities_map.html'")
