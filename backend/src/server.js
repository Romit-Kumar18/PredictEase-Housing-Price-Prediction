const express = require("express");
const cors = require("cors");
const axios = require("axios");
require("dotenv").config();

const app = express();
const ML_SERVICE_URL = process.env.ML_SERVICE_URL || "http://localhost:8000";

const corsOptions = {
    origin: ['http://localhost:3000', 'http://your-ec2-public-ip:3000'],
    methods: ['POST', 'GET', 'OPTIONS'],
    allowedHeaders: ['Content-Type']
  };

app.use(cors(corsOptions));
app.use(express.json());
app.options('*', cors(corsOptions));

app.post('/preprocess', async(req,res) => {
    console.log('Received request:', req.method, req.url);
    console.log('Headers:', req.headers);
    console.log('Body:', req.body);
    try {
        const { INT_SQFT, N_BEDROOM, N_BATHROOM, AREA, PARK_FACIL, BUILDTYPE, UTILITY_AVAIL, STREET } = req.body;

        console.log(req.body);

        const areaOptions = ["Adyar", "Anna_Nagar", "Chrompet", "KK_Nagar", "Karapakam", "T_Nagar", "Velachery"];
        const areaEncoded = Object.fromEntries(areaOptions.map(a => [`AREA_${a}`,AREA === a ? 1 : 0]));

        const parkFacilEncoded = {
            PARK_FACIL_No: PARK_FACIL === false? 1 : 0,
            PARK_FACIL_Yes: PARK_FACIL === true? 1 : 0
        }

        const buildTypeOptions = ["Commercial", "House", "Others"]
        const buildTypeEncoded = Object.fromEntries(buildTypeOptions.map(a => [`BUILDTYPE_${a}`, BUILDTYPE === a? 1 : 0]));

        const utilityAvailEncoded = {
            UTILITY_AVAIL_No: UTILITY_AVAIL === 'No'? 1 : 0,
            UTILITY_AVAIL_Yes: UTILITY_AVAIL === 'Yes'? 1:0
        }

        const streetOptions = ['Gravel','No_Access', 'Paved'];
        const streetEncoded = Object.fromEntries(streetOptions.map(a => [`STREET_${a}`, STREET === a? 1:0]))

        const inputData = {
            INT_SQFT: parseInt(INT_SQFT,10),
            N_BEDROOM: parseInt(N_BEDROOM,10),
            N_BATHROOM: parseInt(N_BATHROOM,10),
            ...areaEncoded,
            ...parkFacilEncoded,
            ...buildTypeEncoded,
            ...utilityAvailEncoded,
            ...streetEncoded
        }
        const response = await axios.post(`${ML_SERVICE_URL}/predict`,inputData);

        res.json(response.data);

        console.log(response.data)

    } catch (e) {
        console.error('Full error stack:', e);
        res.status(500).json({ 
            error: e.message,
            stack: process.env.NODE_ENV !== 'production' ? e.stack : undefined
        });
    }
});

app.listen(process.env.PORT, () => {
    console.log(process.env.PORT);
    console.log(process.env.ML_SERVICE_URL);
})