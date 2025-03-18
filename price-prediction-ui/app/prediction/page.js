"use client";

import { useState } from "react";

export default function Home() {
  const [formData, setFormData] = useState({
    sqft: "",
    bedrooms: "",
    bathrooms: "",
    location: "",
    parking: false,
    buildingType: "",
    utility: false,
    streetType: ""
  })

  async function handleSubmit(e) {
    e.preventDefault();

  }

  function handleChange(e) {

  }

  return (
    <div className="size-full overflow-auto bg-white font-[family-name:var(--font-geist-mono)] pb-20">
      <header className="flex flex-col p-5 justify-center items-center border-b-4 border-[#212121] bg-[#313131]">
        <h2 className="text-4xl mb-3 hover:text-orange-500 transition ease-in-out font-bold font-[family-name:var(--font-geist-sans)]">PredictEase</h2>
        <h2>Estimate Chennai property prices instantly</h2>
      </header>
      <div className="flex flex-col pt-6 ml-10 text-black">
        <div className="text-2xl font-semibold">
          Predict Your Property's Price
        </div>
        <div className="mt-4">
          Enter details to get an estimated property price.
        </div>
        <div className="mt-3">
          <form action={handleSubmit} className="flex flex-col">
            <label className="mt-3">Square Feet:</label>
            <input
              className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
              id="sqft"
              name="sqft"
              type="number"
              onChange={handleChange}
              placeholder="Enter Square Footage">
            </input>
            <label className="mt-3">Bedrooms:</label>
            <input
              className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
              id="bedrooms"
              name="bedrooms"
              type="number"
              onChange={handleChange}
              placeholder="Enter Number of Bedrooms">
            </input>
            <label className="mt-3">Bathrooms:</label>
            <input
              className="w-xs p-2 mt-2 mb-2 border-stone-400 border-solid border-2 rounded-md font-[family-name:var(--font-montserrat)]"
              id="bathrooms"
              name="bathrooms"
              type="number"
              onChange={handleChange}
              placeholder="Enter Number of Bathrooms">
            </input>
            <label className="mt-3">Location:</label>
            <select
              className="w-xs border-stone-400 border-solid border-2 rounded-md p-2 mt-2"
              id="location"
              name="location"
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
              name="buildingType"
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
              name="streetType"
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
                name="parking"
                type="checkbox"
                onChange={handleChange}
              >
              </input>
            </div>
            <div className="mt-6 flex">
              <label className="">Utility:</label>
              <input
                className="ml-2 mt-1"
                id="utility"
                name="utility"
                type="checkbox"
                onChange={handleChange}
              >
              </input>
            </div>
            <div className="flex justify-center items-center">
              <button type="submit" className="border-stone-400 cursor-pointer border-solid border-2 rounded-md w-xs mt-10 p-2 text-white transition duration-300 ease-in-out bg-orange-600 hover:bg-blue-600 hover:scale-105">Get Price Estimate</button>
            </div>
          </form>
        </div>
      </div>
      <div className="flex flex-col justify-center items-center">
        <div className="border-solid border-2 border-[#212121] bg-[#414141] mt-10 w-7xl p-6 pl-15 pb-15 rounded-md transition duration-300 hover:scale-105">
          Prediction Result
          <div className="text-center mt-5 pr-10 text-black bg-white border-[#212121] rounded-xl p-10 mr-10">
            Please Search for a Property to Get a prediction
          </div>
        </div>
      </div>
    </div>
  );
}