# Free AI using HuggingFace Inference API
$MODEL = "bigcode/starcoder"
$API_KEY = "FREE_USER_TOKEN"  # Get from huggingface.co

$prompt = Read-Host "Enter coding task"
$response = Invoke-RestMethod -Uri "https://api-inference.huggingface.co/models/$MODEL" `
  -Headers @{"Authorization" = "Bearer $API_KEY"} `
  -Method Post -Body (@{"inputs" = $prompt } | ConvertTo-Json)

$response.generated_text