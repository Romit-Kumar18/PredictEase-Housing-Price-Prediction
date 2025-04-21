import PredictionForm from "../components/predictionForm";

export default function Home() {
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
        <PredictionForm />
      </div>
    </div>
  );
}