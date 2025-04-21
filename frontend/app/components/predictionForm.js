"use client";

import { useState } from "react";

export default function PredictionForm() {
    const [formData, setFormData] = useState({
        INT_SQFT: "",
        N_BEDROOM: "",
        N_BATHROOM: "",
        AREA: "",
        PARK_FACIL: false,
        BUILDTYPE: "",
        UTILITY_AVAIL: false,
        STREET: ""
    })

    const [prediction, setPrediction] = useState(null);

    async function handleSubmit(e) {
        e.preventDefault();
        if (!Object.values(formData).every((value) => value !== "")) {
            alert("Please fill out the form completely");
            return;
        }

        try {
            const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/preprocess`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            });
            const data = await response.json();
            setPrediction(parseInt(data.prediction));
        }
        catch (e) {
            console.log(e.message);
        }
    }

    function handleChange(e) {
        const { name, value, type, checked } = e.target;

        setFormData((prevData) => ({
            ...prevData,
            [name]: type === "checkbox" ? checked : value,
        }));
    }

    return (
        <div>
            <div className="mt-3">
                <form onSubmit={handleSubmit} className="flex flex-col">
                    <label className="mt-3">Square Feet:</label>
                    <input
                        className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
                        id="sqft"
                        name="INT_SQFT"
                        type="number"
                        value={formData.INT_SQFT}
                        onChange={handleChange}
                        placeholder="Enter Square Footage">
                    </input>
                    <label className="mt-3">Bedrooms:</label>
                    <input
                        className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
                        id="bedrooms"
                        name="N_BEDROOM"
                        type="number"
                        value={formData.N_BEDROOM}
                        onChange={handleChange}
                        placeholder="Enter Number of Bedrooms">
                    </input>
                    <label className="mt-3">Bathrooms:</label>
                    <input
                        className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
                        id="bathrooms"
                        name="N_BATHROOM"
                        type="number"
                        value={formData.N_BATHROOM}
                        onChange={handleChange}
                        placeholder="Enter Number of Bathrooms">
                    </input>
                    <label className="mt-3">Location:</label>
                    <select
                        className="w-xs border-stone-400 border-solid border-2 rounded-md p-2 mt-2"
                        id="location"
                        name="AREA"
                        value={formData.AREA}
                        onChange={handleChange}>
                        <option value="">Select Location</option>
                        <option value="Adyar">Adyar</option>
                        <option value="Anna Nagar">Anna Nagar</option>
                        <option value="Chrompet">Chrompet</option>
                        <option value="KK Nagar">KK Nagar</option>
                        <option value="Karapakam">Karapakam</option>
                        <option value="T Nagar">T Nagar</option>
                        <option value="Velachery">Velachery</option>
                    </select>
                    <label className="mt-5">Building Type:</label>
                    <select
                        className="w-xs border-stone-400 border-solid border-2 rounded-md p-2 mt-2"
                        id="buildingType"
                        name="BUILDTYPE"
                        value={formData.BUILDTYPE}
                        onChange={handleChange}>
                        <option value="">Select Building Type</option>
                        <option value="House">Residential</option>
                        <option value="Commercial">Commercial</option>
                        <option value="Others">Other</option>
                    </select>
                    <label className="mt-5">Street Type:</label>
                    <select
                        className="w-xs border-stone-400 border-solid border-2 rounded-md p-2 mt-2"
                        id="streetType"
                        name="STREET"
                        value={formData.STREET}
                        onChange={handleChange}>
                        <option value="">Select Street Type</option>
                        <option value="Paved">Paved</option>
                        <option value="Gravel">Gravel</option>
                        <option value="No Access">No</option>
                    </select>
                    <div className="mt-6 flex">
                        <label className="">Parking:</label>
                        <input
                            className="ml-2 mt-1"
                            id="parking"
                            name="PARK_FACIL"
                            type="checkbox"
                            checked={formData.PARK_FACIL}
                            onChange={handleChange}
                        />
                    </div>
                    <div className="mt-6 flex">
                        <label className="">Utility:</label>
                        <input
                            className="ml-2 mt-1"
                            id="utility"
                            name="UTILITY_AVAIL"
                            type="checkbox"
                            checked={formData.UTILITY_AVAIL}
                            onChange={handleChange}
                        />
                    </div>
                    <div className="flex justify-center items-center">
                        <button type="submit" className="border-stone-400 cursor-pointer border-solid border-2 rounded-md w-xs mt-10 p-2 text-white transition duration-300 ease-in-out bg-orange-600 hover:bg-blue-600 hover:scale-105">Get Price Estimate</button>
                    </div>
                </form>
            </div>
            <div className="flex flex-col justify-center items-center">
                <div className="border-solid border-2 border-[#212121] bg-[#414141] mt-10 w-7xl p-6 pl-15 pb-15 rounded-md transition duration-300 hover:scale-105">
                    Prediction Result
                    <div className="text-center mt-5 pr-10 text-black bg-white border-[#212121] rounded-xl p-10 mr-10">
                        {prediction !== null ? (
                            <span className="text-2xl font-bold text-green-600">Estimated Price: ₹{prediction}</span>
                        ) : (
                            "Please Search For A Property To Get A Prediction"
                        )}
                    </div>
                </div>
            </div>
        </div>
    )
}