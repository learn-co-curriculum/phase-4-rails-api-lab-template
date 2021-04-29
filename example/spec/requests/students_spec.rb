require 'rails_helper'

RSpec.describe 'Students', type: :request do
  describe 'GET /students' do
    before do
      Student.create!(first_name: 'Dwayne', last_name: 'Johnson')
      Student.create!(first_name: 'Vanessa', last_name: 'Kirby')
      
      get '/students'
    end
    
    it 'returns an array of students' do
      expect(response.body).to include_json([
        { first_name: 'Dwayne', last_name: 'Johnson' },
        { first_name: 'Vanessa', last_name: 'Kirby' }
      ])
    end

    it 'eturns a status code of 200 (success)' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /students' do
    context 'with valid params' do
      let!(:student_params) { { first_name: 'Sam', last_name: 'Smith' } }

      it 'creates a new student' do
        expect { post '/students', params: student_params }.to change(Student, :count).by(1)
      end

      it 'returns the student data' do
        post '/students', params: student_params
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          first_name: 'Sam',
          last_name: 'Smith'
        })
      end

      it 'returns a status code of 201 (created)' do
        post '/students', params: student_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let!(:student_params) { { first_name: 'Sam' } }

      before do
        post '/students', params: student_params
      end

      it 'does not create a new student' do
        expect(Student.count).to eq(0)
      end
  
      it 'returns the validation errors' do
        expect(response.body).to include_json({
          error: {
            last_name: ["can't be blank"]
          }
        })
      end

      it 'returns a status code of 422 (unprocessable_entity)' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe 'GET /students/:id' do

    context 'with a valid id' do

      let!(:student) { Student.create!(first_name: 'Dwayne', last_name: 'Johnson') }

      before do
        get "/students/#{student.id}"
      end

      it 'returns the student with the matching id' do
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          first_name: 'Dwayne',
          last_name: 'Johnson'
        })
      end

      it 'returns a status code of 200 (ok)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid id' do
      before do
        get "/students/not_valid"
      end

      it 'returns an error if the student is not found' do
        expect(response.body).to include_json({ error: 'Not Found' })
      end

      it 'returns a status code of 404 (not found)' do
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe 'DELETE /students/:id' do
    
    context 'with a valid id' do

      let!(:student) { Student.create!(first_name: 'Dwayne', last_name: 'Johnson') }
      
      it 'removes the student with the matching id' do
        expect { delete "/students/#{student.id}" }.to change(Student, :count).from(1).to(0)
      end

      it 'returns a status code of 204 (no content)' do
        delete "/students/#{student.id}"

        expect(response).to have_http_status(:no_content)
      end

    end
    
    context 'with an invalid id' do

      before do
        delete "/students/not_valid"
      end

      it 'returns an error if the student is not found' do
        expect(response.body).to include_json({ error: 'Not Found' })
      end

      it 'returns a status code of 404 (not found)' do
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  describe 'PATCH /students/:id' do

    context 'with a valid id' do
      let!(:student) { Student.create!(first_name: 'Dwayne', last_name: 'Johnson') }

      before do
        patch "/students/#{student.id}", params: { first_name: 'Dwayne "The Rock"' }
      end
      
      it 'updates the student with the matching id' do
        # check that the student was updated (reload queries the database to check the updated record)
        expect(student.reload.first_name).to eq('Dwayne "The Rock"')
      end

      it 'returns the updated student object' do
        expect(response.body).to include_json({ 
          id: a_kind_of(Integer),
          first_name: 'Dwayne "The Rock"',
          last_name: 'Johnson'
        })
      end

      it '# returns a status code of 200 (ok)' do
        expect(response).to have_http_status(:ok)
      end

    end
    
    context 'with an invalid id' do

      before do
        patch '/students/not_valid'
      end

      it 'returns an error if the student is not found' do
        expect(response.body).to include_json({ error: 'Not Found' })
      end

      it 'returns a status code of 404 (not found)' do
        expect(response).to have_http_status(:not_found)
      end

    end

  end
end
