import json
import sys

def convert_json_to_tfvars(json_file):
    try:
        with open(json_file, "r") as f:
            data = json.load(f)
        
        tfvars_output = []
        tfvars_output.append('jobs_data = {')

        for code_appli, consignes in data.items():
            tfvars_output.append(f'  "{code_appli}" = {{')
            for consigne, job_ids in consignes.items():
                job_ids_str = ", ".join(str(job_id) for job_id in job_ids)
                tfvars_output.append(f'    "{consigne}" = [{job_ids_str}],')
            tfvars_output.append("  }")
        
        tfvars_output.append("}")
        return "\n".join(tfvars_output)

    except Exception as e:
        print(f"❌ Erreur lors de la conversion JSON -> tfvars : {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python convert_json_to_tfvars.py <input_json_file>", file=sys.stderr)
        sys.exit(1)

    json_file = sys.argv[1]
    tfvars_content = convert_json_to_tfvars(json_file)
    print(tfvars_content)
