from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from weasyprint import HTML
import base64
import io

app = FastAPI()

class PDFRequest(BaseModel):
    html: str  # base64-encoded HTML

@app.post("/generate-pdf")
async def generate_pdf(request: PDFRequest):
    try:
        decoded_html = base64.b64decode(request.html).decode("utf-8")
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Invalid base64 HTML: {e}")

    # Generate the PDF in memory
    pdf_buffer = io.BytesIO()
    HTML(string=decoded_html).write_pdf(
        pdf_buffer,
        pdf_variant="pdf/a-3u",
        custom_metadata=True,
    )
    pdf_buffer.seek(0)

    # Encode PDF back to base64
    encoded_pdf = base64.b64encode(pdf_buffer.read()).decode("utf-8")

    return {"pdf": encoded_pdf}