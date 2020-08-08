%.
%August 9, 2013.
%Nagesh Adluru.
test_source=zeros(length(particles{best_index}.contents),1);
test_target=zeros(length(particles{best_index}.contents),1);
for i=1:length(particles{best_index}.contents)
    test_source(i)=vertexPairs{particles{best_index}.contents(i)}(1);
    test_target(i)=vertexPairs{particles{best_index}.contents(i)}(2);
end
sumabs((particles{best_index}.takenSource'-test_source))
sumabs((particles{best_index}.takenTarget'-test_target))