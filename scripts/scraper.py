# write a script to scrape the  compressed data from the website in csv format compressed in gz folder using api
import requests
import gzip
import csv
import os

def download_file(url, output_file):
    # Send a GET request to the API endpoint
    response = requests.get(url)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Save the response content to a file
        with open(f'{output_file}.gz', 'wb') as file:
            file.write(response.content)
        with gzip.open(f'{output_file}.gz', 'rb') as file:
            # Read the CSV data
            csv_data = file.read().decode('utf-8')
        with open(output_file, 'w', newline='') as file:
            writer = csv.writer(file)
            # Split the CSV data by lines and iterate over them
            for line in csv_data.splitlines():
                # Split each line by commas and write it to the CSV file
                writer.writerow(line.split(','))
        os.remove(f'{output_file}.gz')
        print(f"File '{output_file}' downloaded and saved successfully.")
    else:
        print(f"Failed to download the file. Status code: {response.status_code}")


if __name__ == "__main__":
    data_dict = {"tour_dem_ttw.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_TTW/?format=SDMX-CSV&compressed=true",
                 "tour_dem_extotw.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_EXTOTW/?format=SDMX-CSV&compressed=true",
                 "tour_dem_tnw.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_TNW/?format=SDMX-CSV&compressed=true",}

    for key, value in data_dict.items():
        download_file(value, key)