function ng --description 'Open nvim with MyGrugFar'
    nvim +"bdelete \$PWD/tmp_file | chdir \$PWD | MyGrugFar --nogit=$argv[1]" tmp_file
end
